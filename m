Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423315AbWF1M0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423315AbWF1M0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423316AbWF1M0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:26:04 -0400
Received: from unn-206.superhosting.cz ([82.208.4.206]:9669 "EHLO
	mail.aiken.cz") by vger.kernel.org with ESMTP id S1423315AbWF1M0D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:26:03 -0400
Message-ID: <44A27569.1020005@kernel-api.org>
Date: Wed, 28 Jun 2006 14:26:17 +0200
From: Lukas Jelinek <info@kernel-api.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; cs-CZ; rv:1.7.12) Gecko/20050915
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: Steven Rostedt <rostedt@goodmis.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
References: <44A1858B.9080102@kernel-api.org> <20060627132226.2401598e.rdunlap@xenotime.net> <44A1982C.1010008@kernel-api.org> <Pine.LNX.4.58.0606280543270.32286@gandalf.stny.rr.com> <20060628120536.GF19868@admingilde.org>
In-Reply-To: <20060628120536.GF19868@admingilde.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hoi :)
> 
> when I once experimented with doxygen, I used the following script to
> convert some kerneldoc comments to doxygen syntax:
> 
> #!/usr/bin/perl -wpi
> 
> use strict;
> 
> BEGIN { $::state = 0; }
> 
> if ($::state == 0) {
> 	$::state = 1 if /\/\*\*/;
> } elsif ($::state == 1) {
> 	s/(\*\s+)(struct\s+|enum\s+)?\S+ - /$1/;
> 	s/$/\./ unless /\.$/;
> 	$::state = 2;
> } elsif ($::state == 2) {
> 	s/(\*\s+)\@(\w+):\s+(.*)/$1\\param $2 $3./;
> 	s/(\s+)[%&\@](\S+)/$1$2/g;
> }
> s/\.\.$/./;
> 
> $::state = 0 if /\*\//;
> 

A good idea! Thanks. I will try it and compare to the result of my sed
script.

Lukas

