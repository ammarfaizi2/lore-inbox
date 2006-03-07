Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWCGW6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWCGW6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWCGW6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:58:12 -0500
Received: from mail.fieldses.org ([66.93.2.214]:11935 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S964852AbWCGW6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:58:11 -0500
Date: Tue, 7 Mar 2006 17:58:09 -0500
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: [Patch] Wrong error handling in nfs4acl
Message-ID: <20060307225809.GC14147@fieldses.org>
References: <1141761420.7561.7.camel@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141761420.7561.7.camel@alice>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 08:57:00PM +0100, Eric Sesterhenn wrote:
> hi,
> 
> this fixes coverity id #3. Coverity detected dead code,
> since the == -1 comparison only returns 0 or 1 to error.
> Therefore the if ( error < 0 ) statement was always false.
> Seems that this was an if( error = nfs4... ) statement some time
> ago, which got broken during cleanup.
> Just compile tested.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

Thanks!  Applied to my tree.--b.
