Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbUBXQpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbUBXQpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:45:36 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:24255 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262284AbUBXQpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:45:34 -0500
Date: Tue, 24 Feb 2004 16:44:04 +0000
From: Dave Jones <davej@redhat.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, davem@redhat.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Intel vs AMD x86-64
Message-ID: <20040224164404.GB10157@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	davem@redhat.com, Linus Torvalds <torvalds@osdl.org>
References: <1077590524.8084.237.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077590524.8084.237.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 09:42:05PM -0500, Albert Cahalan wrote:
 > Setting up only one of the IO-MMUs would be neat.

AGPv3 standard mandates that you MUST keep all GARTs coherent,
so this isn't possible.  The amd64 GART driver goes to great
lengths to make sure it does update the northbridges on every
CPU whenever something changes.

		Dave

