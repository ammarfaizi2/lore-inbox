Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVANW23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVANW23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVANW0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:26:02 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:43279 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262195AbVANWTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:19:12 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: David Eger <eger@havoc.gtf.org>, linux-kernel@vger.kernel.org
Subject: Re: gcc randomly crashes on my PowerBook with recent kernels...
Date: Sat, 15 Jan 2005 00:19:05 +0200
User-Agent: KMail/1.5.4
References: <20050113185453.GA10195@havoc.gtf.org>
In-Reply-To: <20050113185453.GA10195@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501150019.05089.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 January 2005 20:54, David Eger wrote:
> I apologize for the vagueness of the message, but for all ye TiBook users,
> over the last couple months of kernels, I've noticed gcc (various versions
> in the 3.0 series randomly), non-deterministically crashing on large builds.

gcc is a very good hardware checker. :)

I had a gcc crashing problem. Turned out to be RAM
timing problem. memtest86 wasn't able to trigger it
for me in overnight runs. gcc does it in seconds -
if you find a "magic" set of compile options and source file.

As you correctly noticed, yu have more chances of hitting
magic in large compiles.

I grabbed crashed gcc's command line from make log
and ran it in endless loop.
I had a crash (SIGSEGV due to mangled pointer) with ~10%
probability.
--
vda

