Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUCXRy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUCXRy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:54:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58786 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263799AbUCXRyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:54:22 -0500
Date: Wed, 24 Mar 2004 12:54:02 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
Message-ID: <20040324175402.GQ31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <4060E24C.9000507@redhat.com.suse.lists.linux.kernel> <16480.59229.808025.231875@napali.hpl.hp.com.suse.lists.linux.kernel> <20040324070020.GI31589@devserv.devel.redhat.com.suse.lists.linux.kernel> <16481.13780.673796.20976@napali.hpl.hp.com.suse.lists.linux.kernel> <20040324072840.GK31589@devserv.devel.redhat.com.suse.lists.linux.kernel> <16481.15493.591464.867776@napali.hpl.hp.com.suse.lists.linux.kernel> <4061B764.5070008@BitWagon.com.suse.lists.linux.kernel> <16481.49534.124281.434663@napali.hpl.hp.com.suse.lists.linux.kernel> <20040324172454.GP31589@devserv.devel.redhat.com.suse.lists.linux.kernel> <p73wu5at9su.fsf@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73wu5at9su.fsf@brahms.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 06:49:21PM +0100, Andi Kleen wrote:
> It's actually not that difficult. You just have to read /proc/self/maps
> and check for the mapping of your current stack pointer.
> For the main stack GROWSDOWN will inherit the x or nx on growing
> down.

That assumes there are always gaps around thread stacks, which doesn't
have to be true.  You could make executable some other mapping
as well easily.

	Jakub
