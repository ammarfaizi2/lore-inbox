Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUGHN0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUGHN0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUGHN0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:26:20 -0400
Received: from guardian.hermes.si ([193.77.5.150]:3603 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S264763AbUGHN0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:26:09 -0400
Message-ID: <600B91D5E4B8D211A58C00902724252C035F1F18@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, fedora-list@redhat.com
Subject: Re: [PATCH 2.6] Mousedev - better button handling under load
Date: Thu, 8 Jul 2004 15:25:41 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Currently mousedev combines all hardware motion data that arrivers
since
	last time userspace read data into one cooked PS/2 packet. The
problem is
	that under heavy or even moderate load, when userspace can't read
data
	quickly enough, we start loosing valuable data which manifests in:

	- ignoring buton presses as by the time userspace gets to read the
data
	  button has already been released;
	- click starts in wrong place - by the time userspace got aroungd
and read
	  the packet mouse moved half way across the screen.


I am seeing the second simptom on Fedora Core 2 in X.
( I click on a windows title, move the mouse and what happens is than a 
selection rectangle is drawn on the desktop, starting a few inches away from
the real click position )
Is this the cause ?

Regards,
David

P.S.: Is there a bug about this in bugzilla.redhat.com ? ( or elsewhere ? )
----------------------------------------------------------------------------
-----------
http://noepatents.org/           Innovation, not litigation !
---
David Balazic                      mailto:david.balazic@hermes.si
HERMES Softlab                 http://www.hermes-softlab.com
Zagrebska cesta 104            Phone: +386 2 450 8851 
SI-2000 Maribor
Slovenija
----------------------------------------------------------------------------
-----------
"Be excellent to each other." -
Bill S. Preston, Esq. & "Ted" Theodore Logan
----------------------------------------------------------------------------
-----------








