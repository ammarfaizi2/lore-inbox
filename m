Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312711AbSCVP00>; Fri, 22 Mar 2002 10:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312712AbSCVP0R>; Fri, 22 Mar 2002 10:26:17 -0500
Received: from new-coyote.egenera.com ([208.51.147.230]:4834 "HELO
	coyote.egenera.com") by vger.kernel.org with SMTP
	id <S312711AbSCVP0M>; Fri, 22 Mar 2002 10:26:12 -0500
Message-ID: <3C9B4CA7.5BD03CCB@egenera.com>
Date: Fri, 22 Mar 2002 10:24:23 -0500
From: "Philip R. Auld" <prauld@egenera.com>
Organization: Egenera Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Little, John" <JOHN.LITTLE@okdhs.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: fork() DoS?
In-Reply-To: <E7B0663E34409F45B77EFDB62AE0E4D2022360BD@s99mail02.okdhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Little, John" wrote:
> 
> I'm really not a programmer, just learning, but was able to bring the system
> to it's knees.  This is a redhat 7.2 kernel.  Is there anyway of preventing
> this?

Use resource limits on users and don't run fork bombs as root :)

> 
> #include <unistd.h>
> 
> void do_fork()
> {
>    pid_t p;
> 
>    p = fork();
>    do_fork();
> }
> 
> void main()
> {
>    for(;;)
>       do_fork();
> }
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St., Marlboro, MA 01752       (508)786-9444
