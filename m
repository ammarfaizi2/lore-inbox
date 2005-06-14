Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVFNX2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVFNX2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVFNX2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:28:13 -0400
Received: from graphe.net ([209.204.138.32]:61087 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261411AbVFNX2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:28:02 -0400
Date: Tue, 14 Jun 2005 16:27:55 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: christoph <christoph@scalex86.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
In-Reply-To: <20050614231911.GV11898@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0506141621510.23266@graphe.net>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de>
 <Pine.LNX.4.62.0506141551350.3676@ScMPusgw> <20050614230411.GU11898@wotan.suse.de>
 <Pine.LNX.4.62.0506141614570.23117@graphe.net> <20050614231911.GV11898@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, Andi Kleen wrote:

> > If these maps would start in the middle of a cacheline then additional 
> > cacheline fetches may become necessary to scan an array etc.
> 
> But the CPUs do prefetching anyways for that. Do you have numbers
> that this is actually worth it? 

Its not only for scanning an array. A struct may contains a lot of 
related information like for example boot_cpu_data. Aligning 
increases locality and the likelyhood that no additional cachelines have 
to be fetched.


