Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbUKCOZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUKCOZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 09:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKCOZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 09:25:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:33727 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261615AbUKCOY6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 09:24:58 -0500
Subject: Re: accept does not return in case a signal arrives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerrit =?ISO-8859-1?Q?Bruchh=E4user?= 
	<gbruchhaeuser@orga-systems.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4188DC90.9030503@orga-systems.com>
References: <4188DC90.9030503@orga-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1099488110.29560.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 03 Nov 2004 13:21:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-03 at 13:26, Gerrit Bruchhäuser wrote:
> Dear Kernel-team,
> 
> on Linux, 'accept' system call does not return in case I send SIGTERM to 
> my application; while it does on OSF-Alpha.

signal() may or may not interrupt some system calls. Use sigaction if
you want to force a given behaviour (and write portable code)

