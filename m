Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135259AbRDXK0j>; Tue, 24 Apr 2001 06:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135306AbRDXK0T>; Tue, 24 Apr 2001 06:26:19 -0400
Received: from pop-mu-8-1-dialup-175.freesurf.ch ([194.230.140.175]:8064 "EHLO
	playstation.hb9jnx.ampr.org") by vger.kernel.org with ESMTP
	id <S135259AbRDXK0N>; Tue, 24 Apr 2001 06:26:13 -0400
Message-ID: <3AE552E8.245B647@alumni.ethz.ch>
Date: Tue, 24 Apr 2001 12:18:16 +0200
From: Thomas Sailer <t.sailer@alumni.ethz.ch>
Organization: IfE
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2jnx i686)
X-Accept-Language: de-CH, en
MIME-Version: 1.0
To: Alex Riesen <a.riesen@traian.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: init_rwsem redefinition warning in usbdevice_fs.h
In-Reply-To: <20010424103607.B5368@traian.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:

> Should it be fixed? And, maybe the other define's around
> should be fixed too?

The comment line above actually says it all. The defines
have been added because at the time of writing this file
rw semaphores did not work in a module, so they were
replaced with mutexes using these defines. If rw sems work
now just delete these defines

Tom
