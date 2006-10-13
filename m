Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWJMRcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWJMRcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWJMRcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:32:12 -0400
Received: from web32409.mail.mud.yahoo.com ([68.142.207.202]:15718 "HELO
	web32409.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751106AbWJMRcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:32:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uQ8LXVy70Iylf2Z3S7Q4siZTEmAzQJ77SOFaR6HM0DeV2/rOfuNpIBgIQ0/bWlPHdsaBIlsG4FEfCyWtDlAnP9FfhSWZbyHOreDqilS8gDTo34HUaJu+tZ0+8ALzOqoEVvuxv0Tmm6J1W2m/NaqeV9Amx5Q+KRhlxfZpjEzaP28=  ;
Message-ID: <20061013173207.2608.qmail@web32409.mail.mud.yahoo.com>
Date: Fri, 13 Oct 2006 10:32:06 -0700 (PDT)
From: Anil kumar <anils_r@yahoo.com>
Subject: page_address issue
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How can I confirm if the address returned from
page_address is correct?
The system is EM64T. My hardware supports only 32bit
DMA.
The kernel is 2.6.16 based (SLES10).
The following is the snippet of the code:
if(cmd->use_sg){

unsigned char *pBuf;
sg = (struct scatterlist *)cmd->request_buffer;

pBuf = (unsigned char
*)page_address(sg->page)+sg->offset

}

The number of DMA buffers returned from dma_map_sg is
one. 
I don't think it involves any page boundary issues as
the length of the buffer and offset are well within
the page.
The command is Inquiry. 
I checked the page is a NOT a HighMemPage

The system is 64bit, but the hardware dma capability
is only 32bit. Has this got something to do?
I also checked swiotlb is enabled.

Any help is greatly appreciated.

with regards,
  Anil


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
