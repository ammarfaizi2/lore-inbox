Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVEHHUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVEHHUu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 03:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVEHHUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 03:20:50 -0400
Received: from web60512.mail.yahoo.com ([209.73.178.175]:16740 "HELO
	web60512.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261409AbVEHHUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 03:20:42 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=fXA+egf9FCOAEJx0UednsuTVlGyCwpYroelFGMGrrPtwTsj4hUpZKAwfHwGB3vZgxwdHZHmILj5imyjVFdnf+aeqpdyPHbcABgLFBrbiDOUqL7FPxhxzKkEGd/u30u0fIGNIN2upuVzmEktWI7et0Lt37F+NOXub80AJt4Ve7Xg=  ;
Message-ID: <20050508072038.24894.qmail@web60512.mail.yahoo.com>
Date: Sun, 8 May 2005 00:20:38 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: oprofile: enabling cpu events
To: Baruch Even <baruch@ev-en.org>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <427CDA00.9040203@ev-en.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Baruch,
But, I am still hitting the same issue.
I am using SuSE 2.6.5, but oprofile code looks
similar.
so i manually made that small change from if
(cpu_model > 3) to if (cpu_model > 100), and did a
make modules and make modules_install.
Then inserted the fresh oprofile module.
# opcontrol --setup  --event=CPU_CLK_UNHALTED
 You cannot specify any performance counter events
 because OProfile is in timer mode.

--- Baruch Even <baruch@ev-en.org> wrote:
> The patch that worked for me against 2.6.6 is
> attached.
> 
> Baruch
> >  arch/i386/oprofile/nmi_int.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: 2.6.6/arch/i386/oprofile/nmi_int.c
>
===================================================================
> --- 2.6.6.orig/arch/i386/oprofile/nmi_int.c
> +++ 2.6.6/arch/i386/oprofile/nmi_int.c
> @@ -313,7 +313,7 @@ static int __init p4_init(void)
>  {
>  	__u8 cpu_model = current_cpu_data.x86_model;
>  
> -	if (cpu_model > 3)
> +	if (cpu_model > 100)
>  		return 0;
>  
>  #ifndef CONFIG_SMP
> 



		
Yahoo! Mail
Stay connected, organized, and protected. Take the tour:
http://tour.mail.yahoo.com/mailtour.html

