Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264709AbRFSS45>; Tue, 19 Jun 2001 14:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbRFSS4q>; Tue, 19 Jun 2001 14:56:46 -0400
Received: from hera.cwi.nl ([192.16.191.8]:19097 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264709AbRFSS4f>;
	Tue, 19 Jun 2001 14:56:35 -0400
Date: Tue, 19 Jun 2001 20:55:44 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106191855.UAA310765.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, tpepper@vato.org
Subject: Re: b_dev vs. b_rdev confusion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> how do the inode->i_dev, i_rdev fit into this?

These are what you see with stat(2).
i_dev gives the device the file is on
i_rdev is usually undefined, but for device special files
it gives the real device.

> Is there a set rule on when/where one should use a buffer head's
> b_dev and when/where one should use b_rdev?

b_dev gives the device the user was thinking about
b_rdev is the actual underlying device

Andries
