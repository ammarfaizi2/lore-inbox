Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbUA0Xaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265677AbUA0Xaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:30:35 -0500
Received: from sea2-f42.sea2.hotmail.com ([207.68.165.42]:57098 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265669AbUA0Xae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:30:34 -0500
X-Originating-IP: [192.52.57.33]
X-Originating-Email: [dreiland@hotmail.com]
From: "Doug Reiland" <dreiland@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: double fault in scheduler()
Date: Tue, 27 Jan 2004 18:30:33 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F42H1GLCbnx3HD0003b68e@hotmail.com>
X-OriginalArrivalTime: 27 Jan 2004 23:30:34.0058 (UTC) FILETIME=[8F83E2A0:01C3E52D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a window in scheduler() where we have switch to the new 
process's mm, but are running on the old process's stack. This stack might 
not be mapped in the new process.

_________________________________________________________________
Get a FREE online virus check for your PC here, from McAfee. 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

