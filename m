Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbUAIUEc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbUAIUEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:04:32 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:61964 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264547AbUAIUE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:04:29 -0500
Date: Fri, 9 Jan 2004 18:15:14 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1-tiny1 tree for small systems
Message-ID: <20040109201514.GG18853@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
References: <20040103030814.GG18208@waste.org> <m13cawi2h8.fsf@ebiederm.dsl.xmission.com> <20040104084005.GU18208@waste.org> <m1ekufgt72.fsf@ebiederm.dsl.xmission.com> <20040105170938.GY18208@waste.org> <m1wu82i6tm.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wu82i6tm.fsf@ebiederm.dsl.xmission.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 08, 2004 at 12:22:29PM -0700, Eric W. Biederman escreveu:
> Matt Mackall <mpm@selenic.com> writes:
> 
> > On Sun, Jan 04, 2004 at 05:00:49PM -0700, Eric W. Biederman wrote:
> > > On the side of useless ugly.  But interesting in what I had to touch
> > > the following patch is a first crude stab at removing block device
> > > support from the kernel.
> > 
> > This looks good. If you can send me a version with
> > /BLOCK_DEVICE/BLOCK/, etc., I'll put it in.
> 
> Ok.  I have just had a chance to clean some things up.  Attached
> is my latest and hopefully clean set up diffs against 2.6.1-rc1-tiny1
 
> diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1.compile-fixes/include/linux/fs.h linux-2.6.1-rc1-tiny1.config-block/include/linux/fs.h
> --- linux-2.6.1-rc1-tiny1.compile-fixes/include/linux/fs.h	Sun Jan  4 00:03:57 2004
> +++ linux-2.6.1-rc1-tiny1.config-block/include/linux/fs.h	Thu Jan  8 11:29:14 2004
> @@ -1210,7 +1214,11 @@
>  extern void sync_supers(void);
>  extern void sync_filesystems(int wait);
>  extern void emergency_sync(void);
> +#ifdef CONFIG_bLOCK
                 ^
                 |
                 |
                 |
                 |

oops :)
