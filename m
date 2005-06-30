Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVF3Le4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVF3Le4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVF3Le0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:34:26 -0400
Received: from gate.in-addr.de ([212.8.193.158]:44965 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262663AbVF3LeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:34:19 -0400
Date: Thu, 30 Jun 2005 13:33:53 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: device-mapper development <dm-devel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] mirroring: [patch 1 of 8] device failure tolerance
Message-ID: <20050630113353.GC31922@marowsky-bree.de>
References: <16a7b346170f3909d57592016a32abc0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16a7b346170f3909d57592016a32abc0@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-06-29T13:07:49, Jonathan E Brassow <jbrassow@redhat.com> wrote:

> This patch defines a couple more states that logs can return, and 
> checks for those states in the mirror code.  The states are useful for 
> logs that have cluster support.

OK. Let me just ask one question, which I'll preface with the following:

I totally love the idea of md / DM convergence. I'm not yet quite clear
how this is to be achieved, but having two separate frameworks which at
least considerable overlap doesn't make sense - this isn't like two
filesystems, this is like two VFS layers and obviously silly. So, I
appreciate movement into that direction.

However, what's going on now is that features are being added to the DM
raid code, instead of figuring out a path of convergence.

RAID code takes, that's the experience we've got with Linux so far,
quite some time to stabilize. Duplicating it definetely doesn't seem
smart, if I may be so blunt. The RAID code in md is, nowadays, very
stable, and even already has patches for faster resync etc (merged in
-mm).

md is, in certain ways, more mature, which is exemplified by md's
ability to actually provide sane logging. DM has new cool features (like
the online remapping and stuff).

Why is the approach of reinventing a wheel with a slightly different
number of edges taken?

Is it believed that DM will supersede all aspects of md one day? Ain't
that slightly silly? ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

