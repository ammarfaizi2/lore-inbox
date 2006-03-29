Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWC2WjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWC2WjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWC2WjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:39:13 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:35270 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751105AbWC2WjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:39:12 -0500
Subject: Re: [2.6.16] reiserfs3 and swap scheduling while atomic:
	mount/0x00000001/1108
From: Lee Revell <rlrevell@joe-job.com>
To: Daniel =?ISO-8859-1?Q?Schr=F6der?= <mail@dschroeder.info>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <442ACDED.9040304@dschroeder.info>
References: <442ACDED.9040304@dschroeder.info>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 29 Mar 2006 17:39:06 -0500
Message-Id: <1143671947.13933.51.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 20:11 +0200, Daniel Schröder wrote:
>  [<c0118020>] default_wake_function+0x0/0x20
>  [<c02b7e0b>] synth_buffer_add+0x7b/0xa0
>  [<c02b7e4c>] synth_write+0x1c/0x70
>  [<c02b4994>] spkup_write+0xe4/0x340
>  [<c02b0216>] vt_console_print+0xb6/0x2e0

> synth probe
> initialized device: /dev/softsynth, node (MAJOR 10, MINOR 26)
> initialized device: /dev/synth, node ( MAJOR 10, MINOR 25 )
> 
> #
> # Speakup console speech
> #
> CONFIG_SPEAKUP=y

You appear to be using a third party in-kernel screen reader, that
causes printk() to call into a sleeping function which is illegal.

If the only symptom is the warnings this could safely be ignored.  The
real solution is to fix your screen reader.

(When reporting bugs on LKML, please be sure to mention any third party
kernel drivers you are using)

Lee

