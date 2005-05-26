Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVEZMqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVEZMqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVEZMqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:46:16 -0400
Received: from relay3.usu.ru ([194.226.235.17]:10228 "EHLO relay3.usu.ru")
	by vger.kernel.org with ESMTP id S261376AbVEZMqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:46:12 -0400
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Date: Thu, 26 May 2005 18:47:54 +0600
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <42947A75.nail1XA2FQPXX@burner> <B12D948C-4CE9-4139-B0D6-68F8526D0F43@mac.com> <4295A1A5.nail2SW21JHSO@burner>
In-Reply-To: <4295A1A5.nail2SW21JHSO@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261847.54977.patrakov@ums.usu.ru>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.30.0.15; VDF: 6.30.0.202; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 16:15, Joerg Schilling wrote:

> The problem was that you could send SCSI commands on R/O fds and fixing the
> problem would have been to forbid sending SCSI commands on R/O fds.

Unfortunately, this is not going to work. It would work only if the only app 
that has to send SCSI commands were cdrecord. Then really, a non-setuid 
program just would not be able to get a R/W fd, and setuid ones are assumed 
to be trusted.

The problem is that many CD audio players also send SCSI commands in order to 
extract digital audio data. Are you proposing to make them setuid root? use a 
well-defined setuid helper? other solution?

-- 
Alexander E. Patrakov
