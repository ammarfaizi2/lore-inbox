Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262865AbRE3W3K>; Wed, 30 May 2001 18:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbRE3W2u>; Wed, 30 May 2001 18:28:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36617 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262865AbRE3W2l>; Wed, 30 May 2001 18:28:41 -0400
Subject: CML1 ruleset code
To: linux-kernel@vger.kernel.org
Date: Wed, 30 May 2001 23:26:42 +0100 (BST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155EQM-0006k5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've put an updated version of the rule engine on

ftp.linux.org.uk:pub/linux/alan/cml1-load.c

This allows for then to be on a line of its own and the use of 'unset' which
is an unofficial bogosity the alpha people seem to have invented

Haven't fixed the TODO items yet

Example output:

Variable CONFIG_DMA_NONPCI: 
{
    {
    All of:
        $CONFIG_IDE!= n
    }
    AND
    {
    Not all of:
        $CONFIG_BLK_DEV_TIVO= y
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
        $CONFIG_IDE!= n
    }
    AND
    {
    All of:
        $CONFIG_BLK_DEV_TIVO= y
    }
    AND
    {
    Subset of:
        y
    }
}

