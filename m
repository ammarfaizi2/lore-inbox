Return-Path: <linux-kernel-owner+w=401wt.eu-S1750804AbWLVRD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWLVRD4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWLVRD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:03:56 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:57185 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbWLVRD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:03:56 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: hot ejection of CardBus cards and ExpressCards
Date: Fri, 22 Dec 2006 18:05:43 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <458BB6CA.4080203@s5r6.in-berlin.de>
In-Reply-To: <458BB6CA.4080203@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612221805.43735.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. Dezember 2006 11:43 schrieb Stefan Richter:
> Would-be driver programmer's question #217:
> How has a driver's remove routine to account for hot ejection of a PCI
> device? Does it merely boil down to that writing to device registers
> doesn't have side effects anymore or is there more to it?

Reading will return 0xFF. And you have to deregister the device and free
resources from your disconnect() method.

	HTH
		Oliver
