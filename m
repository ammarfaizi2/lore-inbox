Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbRCLH0o>; Mon, 12 Mar 2001 02:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRCLH0f>; Mon, 12 Mar 2001 02:26:35 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23739 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129453AbRCLH0T>;
	Mon, 12 Mar 2001 02:26:19 -0500
Message-ID: <3AAC79D1.F9837EE7@mandrakesoft.com>
Date: Mon, 12 Mar 2001 02:25:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, elenstev@mesatop.com,
        kbuild-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>
Subject: Re: Rename all derived CONFIG variables
In-Reply-To: <20736.984380602@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> In 2.4.2-ac18 there are 130 CONFIG options that are always derived from
> other options, the user has no control over them.  It is useful for the
> kernel build process to know which variables are derived and which
> variables the user can control.  There are also 6 CONFIG options that
> are not used anywhere.
> 
> ftp://ftp.ocs.com.au/pub/2.4.2-ac18-config_derived.gz
> 
> is a 583,904 byte (unzipped) 114,291 (gzipped) patch which removes the
> unused variables and renames the 130 derived variables from CONFIG_FOO
> to CONFIG_FOO_DERIVED.  The affected variables are :-

Not only do I think that CONFIG_xxx_DERIVED needlessly extends the name
of derived vars, but your patch does not belong in a stable series. 
Derived CONFIG_xxx vars are likely to be referenced in source.  Changing
those vars in the middle of a stable series pointlessly breaks external
source code.

I hope vendors don't start applying this patch...

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
