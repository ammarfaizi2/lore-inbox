Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVIEOPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVIEOPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVIEOPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:15:08 -0400
Received: from gate.in-addr.de ([212.8.193.158]:5250 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751266AbVIEOPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:15:06 -0400
Date: Mon, 5 Sep 2005 16:14:32 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@istop.com>, Andi Kleen <ak@suse.de>
Cc: linux clustering <linux-cluster@redhat.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
Message-ID: <20050905141432.GF5498@marowsky-bree.de>
References: <20050901104620.GA22482@redhat.com> <20050901132104.2d643ccd.akpm@osdl.org> <p73fysnqiej.fsf@verdi.suse.de> <200509030157.31581.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200509030157.31581.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-09-03T01:57:31, Daniel Phillips <phillips@istop.com> wrote:

> The only current users of dlms are cluster filesystems.  There are zero users 
> of the userspace dlm api. 

That is incorrect, and you're contradicting yourself here:

> What does have to be resolved is a common API for node management.  It is not 
> just cluster filesystems and their lock managers that have to interface to 
> node management.  Below the filesystem layer, cluster block devices and 
> cluster volume management need to be coordinated by the same system, and 
> above the filesystem layer, applications also need to be hooked into it.  
> This work is, in a word, incomplete.

The Cluster Volume Management of LVM2 for example _does_ use simple
cluster-wide locks, and some OCFS2 scripts, I seem to recall, do too.

(EVMS2 in cluster-mode uses a verrry simple locking scheme which is
basically operated by the failover software and thus uses a different
model.)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

