Return-Path: <linux-kernel-owner+w=401wt.eu-S932965AbXABIRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbXABIRM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 03:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932971AbXABIRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 03:17:12 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:51185 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965AbXABIRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 03:17:11 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-kernel@vger.kernel.org
Subject: doubts on file_pos_write()
Date: Tue, 2 Jan 2007 09:17:12 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701020917.12896.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as loff_t is a 64 bit value, it seems to me to a simple assignment
in file_pos_write() means that the offset can be turned into garbage
doing concurrent reads with shared fds around the 4GB limit on 32 bit
architectures.
Comments?

	Regards
		Oliver
