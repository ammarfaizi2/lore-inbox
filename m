Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbTE1Jpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 05:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbTE1Jpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 05:45:32 -0400
Received: from luminis.xs4all.nl ([213.84.241.134]:16039 "EHLO
	birdie.luminis.net") by vger.kernel.org with ESMTP id S264638AbTE1Jpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 05:45:31 -0400
Message-ID: <48531.212.153.190.2.1054116191.squirrel@www.luminis.net>
Date: Wed, 28 May 2003 12:03:11 +0200 (CEST)
Subject: How do I implement a use counter for 2.5 modules?
From: "Marcel Offermans" <marcel.offermans@luminis.nl>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently porting a CAN driver module from 2.4 to 2.5 and one of the
things I did was remove the MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT macros
from the code. This now means that rmmod will remove my module even when
it is still in use. What mechanism should I use to prevent this? I know
how to logically detect if the module is in use (there's a variable that
keeps track of this already in the code), I just don't know what new API I
should use.


