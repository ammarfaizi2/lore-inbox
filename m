Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262774AbRE3NFI>; Wed, 30 May 2001 09:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262777AbRE3NE5>; Wed, 30 May 2001 09:04:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23315 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262774AbRE3NEv>; Wed, 30 May 2001 09:04:51 -0400
Subject: CML1: Who says you can't turn it into a ruleset ?
To: linux-kernel@vger.kernel.org
Date: Wed, 30 May 2001 14:02:48 +0100 (BST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1555ce-0005xG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally got time to hack a little on the CML1 ruleset problem and my app
now happily turns CML1 into constraint sets. It core dumps at the end, and
it doesnt build the exclusivity rules for choice sets yet but..

Variable CONFIG_USB_UHCI_ALT: 
{
    {
    Not all of:
        $CONFIG_USB_UHCI!= y
    }
    AND
    {
    Subset of:
        n
    }
}
OR
{
    {
    All of:
        $CONFIG_USB_UHCI!= y
    }
    AND
    {
    Subset of:
        $CONFIG_USB
    }
}


as a sample.

Alan

