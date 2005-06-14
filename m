Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVFNXSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFNXSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVFNXR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:17:59 -0400
Received: from graphe.net ([209.204.138.32]:5546 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261409AbVFNXRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:17:19 -0400
Date: Tue, 14 Jun 2005 16:17:14 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: christoph <christoph@scalex86.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
In-Reply-To: <20050614230411.GU11898@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0506141614570.23117@graphe.net>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de>
 <Pine.LNX.4.62.0506141551350.3676@ScMPusgw> <20050614230411.GU11898@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, Andi Kleen wrote:

> > Hmm. No. The bigger cpu maps may benefit from cacheline alignment for 
> > even for read access. 
> 
> Why? Can you please explain that. It doesn't make sense to me.

Its more likely to get a big piece of the array in a single 
cacheline if the array starts at the beginning of a cacheline.

If these maps would start in the middle of a cacheline then additional 
cacheline fetches may become necessary to scan an array etc.


