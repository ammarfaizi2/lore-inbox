Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVD0Puv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVD0Puv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVD0Puv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:50:51 -0400
Received: from gate.in-addr.de ([212.8.193.158]:26560 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261756AbVD0Pud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:50:33 -0400
Date: Wed, 27 Apr 2005 17:50:22 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Martin Mares <mj@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427155022.GR4431@marowsky-bree.de>
References: <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050427153320.GA19065@atrey.karlin.mff.cuni.cz>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-27T17:33:20, Martin Mares <mj@ucw.cz> wrote:

> > It is not there for the purpose of protecting user's data.  Rather for
> > protecting other users (including root) from unknowingly entering the
> > FUSE directory and thus leaking otherwise inaccessible information
> > (exact file operations performed) to the mount owner.
> 
> Huh? Do you really suppose that there could be anything secret in the
> operations somebody else is performing on your files?

It is certainly an information leak not otherwise available. And with
the ability to change the layout underneath, you might trigger bugs in
root programs: Are they really capable of seeing the same filename
twice, or can you throw them into a deep recursion by simulating
infinitely deep directories/circular hardlinks...?

Certainly a useful tool for hardening applications, but I can see the
point of not wanting to let unwary applications run into a namespace
controlled by a user. Of course, this is sort-of similar to "find
-xdev", but I'm not sure whether it is not indeed new behaviour.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

