Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbTFMBxC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 21:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTFMBxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 21:53:02 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:61515 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265100AbTFMBxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 21:53:00 -0400
Date: Thu, 12 Jun 2003 22:07:03 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: David Schwartz <davids@webmaster.com>
cc: Muthian Sivathanu <muthian_s@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: RE: limit resident memory size
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOEBMDKAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.44.0306122206010.29919-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003, David Schwartz wrote:

> > I would like to limit the maximum resident memory size
> > of a process within a threshold, i.e. if its virtual
> > memory footprint exceeds this threshold, it needs to
> > swap out pages *only* from within its VM space.
> 
> 	Why? If you think this is a good way to be nice to other
> processes, you're wrong.

RSS limits are a good idea, provided that they are only
enforced when the system is low on memory.  Once the system
starts swapping and is into the "lots of disk IO" territory
anyway, it can be a good idea to have the processes that
exceed their RSS limit suffer more than the ones that don't.

