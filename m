Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVEQWQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVEQWQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVEQWQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:16:56 -0400
Received: from mail0.lsil.com ([147.145.40.20]:45201 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262024AbVEQWOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:14:06 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CCE96@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       Arjan van de Ven <arjan@infradead.org>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: RE: [PATCH 2.6.12-rc4-mm1 3/4] megaraid_sas: updating the driver
Date: Tue, 17 May 2005 18:13:49 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Mon, 2005-05-16 at 10:06 +0200, Arjan van de Ven wrote:
>> > +			spin_lock( instance->host_lock );
>> > +			cmd->scmd->scsi_done( cmd->scmd );
>> > +			spin_unlock( instance->host_lock );
>> 
>> are you really sure you don't want to use spin_lock_irqsave() here ?
>
>Actually, don't bother with the lock at all.  scsi_done() is 
>designed to
>be called locklessly.
>
>James

Okay. I will remove that.

Thanks,
Sreenivas
