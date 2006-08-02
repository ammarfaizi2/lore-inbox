Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWHBB3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWHBB3A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 21:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWHBB3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 21:29:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61391 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750949AbWHBB27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 21:28:59 -0400
Date: Tue, 1 Aug 2006 21:28:52 -0400
From: Dave Jones <davej@redhat.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roland Dreier <rdreier@cisco.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fbcon: Use persistent allocation for cursor blinking.
Message-ID: <20060802012852.GD22589@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Antonino A. Daplas" <adaplas@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roland Dreier <rdreier@cisco.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20060801185618.GS22240@redhat.com> <adairlc5ktk.fsf@cisco.com> <1154470813.15540.95.camel@localhost.localdomain> <44CFFDF1.6030909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CFFDF1.6030909@gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 09:20:49AM +0800, Antonino A. Daplas wrote:

 > >> A naiive question from someone who knows nothing about this subsystem:
 > >> is there any possibility of concurrent calls into this function, for
 > >> example if there are multiple cursors on a multiheaded system?
 > > 
 > > We don't do console multihead so its basically OK. Moving all the
 > > console globals into a struct so we can have multiple instances would be
 > > a good thing [tm] and it would make sense for the variable to end up in
 > > said structure if it was done.
 > > 
 > 
 > Here's an update. Taking Alan's cue, I just moved the global variables
 > to struct fbcon_ops.

Good job.  Have another..

Signed-off-by: Dave Jones <davej@redhat.com>

		Dave

-- 
http://www.codemonkey.org.uk
