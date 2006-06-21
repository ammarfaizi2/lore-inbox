Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWFUVya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWFUVya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWFUVya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:54:30 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:60857 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030188AbWFUVy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:54:29 -0400
Date: Wed, 21 Jun 2006 17:54:26 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Christoph Lameter <clameter@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
       David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 2/3] SELinux: add security_task_movememory calls to mm
 code
In-Reply-To: <Pine.LNX.4.64.0606211438270.22367@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606211752280.13041@d.namei>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei>
 <Pine.LNX.4.64.0606211730540.12872@d.namei> <Pine.LNX.4.64.0606211734480.12872@d.namei>
 <Pine.LNX.4.64.0606211438270.22367@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Christoph Lameter wrote:

> This check is before the validity of nodes has been verified but 
> the check in sys_migrate_pages is after the checking of the nodes.

This should be fine, as we're only checking at a broad level whether the 
task has permission to perform the operation at all.  We do not poke 
around inside to see which nodes are being referenced.


(did 1/3 make it to the list?)


- James
-- 
James Morris
<jmorris@namei.org>
