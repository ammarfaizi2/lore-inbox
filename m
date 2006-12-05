Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968265AbWLEPDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968265AbWLEPDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968262AbWLEPDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:03:36 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:53592 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968260AbWLEPDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:03:35 -0500
Subject: Re: [PATCH  v2 04/13] Connection Manager
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <ada3b7uhqlk.fsf@cisco.com>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	 <20061202224958.27014.65970.stgit@dell3.ogc.int>
	 <20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com>
	 <20061205050725.GA26033@2ka.mipt.ru>  <ada3b7uhqlk.fsf@cisco.com>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 09:03:35 -0600
Message-Id: <1165331015.16087.16.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 21:13 -0800, Roland Dreier wrote:
>  > It is for iwarp/rdma from description.
> 
> Yes, iWARP on top of 10G ethernet.
> 
>  > If it is 10ge, then why does it parse incomping packet headers and
>  > implements initial tcp state machine?
> 
> To establish connections to run RDMA over, I guess.  iWARP is RDMA
> over TCP.
> 

The driver uses messages exchanged to and from the HW via the Ethernet
driver to setup TCP connections.  No TCP processing is done in the host.
The hardware does all the TCP processing.


Steve.



