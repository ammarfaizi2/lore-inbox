Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266258AbUHVGYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUHVGYr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 02:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUHVGYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 02:24:47 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:17912 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S266258AbUHVGYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 02:24:45 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Brad Campbell'" <brad@wasp.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sun, 22 Aug 2004 09:24:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <41283A74.101@wasp.net.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSID+fqmf++IfjtQt+6ArBY8O0CAAACN0wg
Message-Id: <S266258AbUHVGYp/20040822062445Z+1742@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

**Indeed there is no longer such a need to recalculate the IP checksum
because I have found a way to disable it by patching the kernel. So, only
requirement is this;

Change the source address of the packet before it reaches to the socket
buffer aka skbuff.h. Because if it reaches that code with the wrong IP
header, the csum will just drop it away.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Brad Campbell
Sent: Sunday, August 22, 2004 8:17 AM
To: Josan Kadett
Cc: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

So if we took any packet that came in from 192.168.1.1 and substituted
192.178.77.1 for the Source 
address and then re-calculated the IP checksum you would be up and running?

Regards,
Brad


