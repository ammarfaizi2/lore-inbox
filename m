Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbREQTFj>; Thu, 17 May 2001 15:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbREQTF3>; Thu, 17 May 2001 15:05:29 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23021 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261505AbREQTFR>;
	Thu, 17 May 2001 15:05:17 -0400
Message-ID: <3B0420EA.DD8D4015@mandrakesoft.com>
Date: Thu, 17 May 2001 15:05:14 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <E150QuA-0005ah-00@the-village.bc.nu> <20010517204616.K754@nightmaster.csn.tu-chemnitz.de> <20010517210023.A1052@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> --- linux-2.4.4-ac10/include/linux/raid/md_k.h.orig     Thu May 17 19:35:41
> 2001
> +++ linux-2.4.4-ac10/include/linux/raid/md_k.h  Thu May 17 19:36:15 2001
> @@ -38,6 +38,8 @@
>                 case RAID5:             return 5;
>         }
>         panic("pers_to_level()");
> +
> +       return 0;
>  }

panic should be marked attribute(noreturn), so gcc is being silly here
by warning at all.

I do this too, because IMHO its inline and won't make things bigger just
shut up the warning.  But Alan will yell at you for fixing gcc bugs in
the kernel source :)

Also, add a comment "fixes gcc warning" next to the code, so people know
why it's there.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
