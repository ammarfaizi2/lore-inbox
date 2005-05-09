Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVEIRzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVEIRzC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 13:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVEIRzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 13:55:01 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:6549 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261464AbVEIRys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 13:54:48 -0400
Message-ID: <427FA3D4.1080706@nortel.com>
Date: Mon, 09 May 2005 11:54:28 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@linnovative.dk>
CC: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any work in implementing Secure IPC for Linux?
References: <Xine.LNX.4.44.0505091058560.5582-100000@thoron.boston.redhat.com> <200505091940.22260.ks@linnovative.dk>
In-Reply-To: <200505091940.22260.ks@linnovative.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Sørensen wrote:

>  By "secure IPC" is meaning a 
> security mechanism that provides a more fine granularity of specifying who 
> are allowed to send (or receive) messages... and maby also a way to resolve 
> the question of "Can I trust the message I received?"

How about unix sockets?
	--you can have sockets in the filesystem namespace with regular file 
permissions to control who is allowed to send messages to particular 
addresses
	--you can authenticate who is sending the message using SCM_CREDENTIALS
	--nobody else can eavesdrop on the messages

Chris
