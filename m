Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTEUV4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 17:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTEUV4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 17:56:31 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:44168 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262261AbTEUV4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 17:56:30 -0400
Subject: Re: Module problems with gcc-3.2.x (please CC
	hamilton@sedsystems.ca)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Kendrick Hamilton <hamilton@sedsystems.ca>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305211512210.3274-300000@sw-55.sedsystems.ca>
References: <Pine.LNX.4.44.0305211512210.3274-300000@sw-55.sedsystems.ca>
Content-Type: text/plain
Message-Id: <1053554963.586.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 22 May 2003 00:09:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-21 at 23:20, Kendrick Hamilton wrote:
> Hi,
> 	I have been continuing the track down problems with a module I am 
> making. If I compile the kernel and module with gcc-2.95.3, the module 
> installs and works correctly. If I compile the kernel and module with 
> gcc-3.2.3, the module finishes installation and its interrupt service 
> routine runs, then the kernel crashes. I am using linux 2.4.18 and 2.4.20. 
> The computers are all pentium computers (I, II, III, celeron, xeon) with 
> Redhat Linux 7.3. Any suggestions would be appreciated.

Can't offer any suggestion, except that I suffered the same pain as you
with 2.5.69-mm7: if I compile 2.5.69-mm7 with gcc 3.2.3, the ymfpci
(Yamaha DS-XG PCI driver) causes a lot of problems, like oopses when
compiled as a module, or panics when built-in.

The problems went away the moment I compiled using gcc 2.96. I think
this is caused by some gcc compiler bug (in fact, I've never been able
to make gcc 3.2 compile itself and pass all tests).

