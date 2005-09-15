Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbVIOX6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbVIOX6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 19:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbVIOX6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 19:58:47 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:54914 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030515AbVIOX6q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 19:58:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PN/MofdDm2cNu4CpQHbRpEf5JqsdishtjPE62tcKAaBx775gn8jrw8Z2c7Vylc9n2lkqw2/367V0hnG/NycA6/RcmhdgGsOcTMYxnfeOfC0zK+nuikprReR3ZKfz/R1r8BgTh+qGLFu4wLNUs6lk/DRGHaflI0K3rCgljGroWVI=
Message-ID: <6bffcb0e05091516585883ae82@mail.gmail.com>
Date: Fri, 16 Sep 2005 01:58:45 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] 2.6.13-mm3 ort v.b6 (OOPS Reporting Tool), try2
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200509151736.35050.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43276366.80304@gmail.com>
	 <Pine.LNX.4.61.0509140436090.4846@lancer.cnet.absolutedigital.net>
	 <4327FD7B.1040300@bilug.linux.it>
	 <200509151736.35050.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/09/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Apply the small patch below on top of it, and you can add
> 
>    Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> 
> 
> 
> --- linux-2.6.14-rc1/scripts/ort.sh.orig        2005-09-15 17:32:02.000000000 +0200
> +++ linux-2.6.14-rc1/scripts/ort.sh     2005-09-15 17:33:08.000000000 +0200
> @@ -98,12 +98,12 @@
>  }
> 
>  check_which() {
> -        WHICH=`which $1`
> +        WHICH=`which $1 2> /dev/null`
>          if [ "$WHICH" != "" ]
>          then
>                  echo -e " [available]"
>          else
> -                echo
> +                echo -e " [not available]"
>          fi
>  }
> 
> @@ -859,8 +859,7 @@
 
Ok. I'll add it to v.b7

Regards,
Michal Piotrowski
