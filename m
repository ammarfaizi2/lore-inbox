Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTLYQq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 11:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTLYQq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 11:46:59 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:54982 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264322AbTLYQq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 11:46:57 -0500
Date: Thu, 25 Dec 2003 17:46:28 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Gergely Tamas <dice@mfa.kfki.hu>
Cc: Keith Lea <keith@cs.oswego.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 data loss
Message-ID: <20031225164628.GB22578@louise.pinerecords.com>
References: <3FEA0C3C.9090601@cs.oswego.edu> <20031224222217.GA3408@mfa.kfki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031224222217.GA3408@mfa.kfki.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-24 2003, Wed, 23:22 +0100
Gergely Tamas <dice@mfa.kfki.hu> wrote:

> I've been hit by the same problem but using 2.6.0 . As you described,
> garbage in files (eg. /etc/modules.conf, ...).
> 
> 2.6.0, Slackware 9.1

Count me in.

IBM ThinkPad T40p (PIIX IDE HDD access)
slackware-current
linux-2.6.0
reiserfs-3.6

I can reproduce the problem anytime simply by terminating an XDM session.

	- complete freeze
	- blank screen
	- can't see an oops
	- nothing in the logs
	- kernel won't panic (tried w/ the morsecode panics patch)
	- typically corrupted files (random garbage in the middle):
		/lib/modules/2.6.0/modules.dep
		/var/adm/messages

I'm hesitant in blaming hdd write cache since there's no power outage
involved (also I've never seen this before w/ 2.4).

-- 
Tomas Szepe <szepe@pinerecords.com>
