Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWJQUxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWJQUxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWJQUxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:53:36 -0400
Received: from cap31-3-82-227-199-249.fbx.proxad.net ([82.227.199.249]:42925
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750715AbWJQUxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:53:34 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20061017203004.555659000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 17 Oct 2006 22:30:04 +0200
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@openvz.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [patch -mm 0/7] pid namespace and namespace cleanups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The next serie contains some cleanups on namespaces that have been
lying in our container patchset for a while. The patches seem stable
enough and not too controversial to be good candidates for a -mm merge.

Here's a short summary of what they are doing :

* add a process_session() helper routine
* rename 'struct namespace' to 'struct mnt_namespace' 
* add pid namespace framework to nsproxy but without the unshare
  feature
* add a child_reaper per pid namespace
* add an id to nsproxy for a future syscall bind_ns

A next serie should follow soon, which depends on the above. 

* net namespace framework, empty object without any dependency on
  the layer
* unshare_ns syscall (unshare dedicated to namespaces with its own 
  flags) 
* bind_ns syscall enabling a process to switch nsproxy
* more cleanups for the pid namespace

Pending patches we are still working on :

* layer 3 net namespace providing a simple and fast isolation of
  a net interface
* full pid namespace, this is quite complex.

Thanks,

C.

