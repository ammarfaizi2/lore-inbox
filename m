Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbULVWQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbULVWQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 17:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbULVWQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 17:16:31 -0500
Received: from sziami.cs.bme.hu ([152.66.242.225]:43220 "EHLO sziami.cs.bme.hu")
	by vger.kernel.org with ESMTP id S262064AbULVWQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 17:16:29 -0500
Date: Wed, 22 Dec 2004 23:16:23 +0100
From: Egmont Koblinger <egmont@uhulinux.hu>
To: linux-kernel@vger.kernel.org
Subject: wrong hardlink count for /proc/PID directories
Message-ID: <20041222221623.GA706@cs.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tested on some 2.6.[7-9] kernels: a stat call for a /proc/SOMEPID
directory returns a hard link count of 3, which is invalid, since these
directories have three subdirectories (attr, fd and task) and hence the hard
link counter should be 5.

This causes at least 'find' (gnu findutils) to malfunction, it does not
descend under /proc/SOMEPID/fd and /proc/SOMEPID/attr. See also:
https://savannah.gnu.org/bugs/index.php?func=detailitem&item_id=11379



bye,

Egmont
