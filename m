Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVALQVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVALQVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVALQVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:21:06 -0500
Received: from main.gmane.org ([80.91.229.2]:30435 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261208AbVALQVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:21:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Truoble with 8-pixel screen fonts and 2.6 kernels (2.6.9, 2.6.10)
Date: Wed, 12 Jan 2005 21:22:33 +0500
Message-ID: <cs3iou$ibs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsa.physics.usu.ru
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This report is on behalf of Declan Moriarty)

To reproduce the problem, install the "kbd" package, and from the first
virtual console execute the following command:

setfont lat1-08          # or any other 8-pixel font

Then switch to the second console and see that the cursor disappeared.
Moreover, the following escape sequences function improperly:

echo -e '\033[?Xc' where X is a digit

Even more, from the second console this command

setfont lat1-16

gives 43 screen lines with only upper halves of characters (bottoms are cut,
and I suspect this also happens with the cursor).

Looks like a bug in the character cell height logic. Could you please fix it
or at least point me to some overview of the relevant source files?

-- 
Alexander E. Patrakov

