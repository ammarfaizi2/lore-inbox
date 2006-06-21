Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWFUUH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWFUUH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWFUUH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:07:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20902 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030204AbWFUUHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:07:25 -0400
Date: Wed, 21 Jun 2006 13:07:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: James Morris <jmorris@namei.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
       David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 2/3] SELinux: add security_task_setmempolicy hooks to mm
 code
In-Reply-To: <Pine.LNX.4.64.0606211544420.11782@d.namei>
Message-ID: <Pine.LNX.4.64.0606211306050.21504@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei>
 <Pine.LNX.4.64.0606211520540.11782@d.namei>
 <Pine.LNX.4.64.0606211230230.21024@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606211544420.11782@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, James Morris wrote:

> I'll let David and/or Stephen address this in detail, but what's being 
> added here is a security asbtraction, where we consider these operations 
> to be equivalent from an access control point of view.  So, one task 
> causing another task's memory to be moved to another node is conisdered to 
> be "setting memory policy" at a conceptual level.  Perhaps we could change 
> the name of the hook to make that clearer (which you suggest below).

That will cause lots of confusion. Moving memory is not a memory policy.

Why was this name picked? Use move_pages movemem or so.

