Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUHDJm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUHDJm4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUHDJmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:42:55 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:13986 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262380AbUHDJmy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:42:54 -0400
From: Duncan Sands <baldrick@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops at bttv_risc_packed (2.6.8-rc1)
Date: Wed, 4 Aug 2004 11:42:49 +0200
User-Agent: KMail/1.6.2
References: <200408032123.42078.baldrick@free.fr>
In-Reply-To: <200408032123.42078.baldrick@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041142.49076.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bttv_risc_packed:

                       while (todo > sg_dma_len(sg)) {
                                *(rp++)=cpu_to_le32(BT848_RISC_WRITE|
                                                    sg_dma_len(sg));
                                *(rp++)=cpu_to_le32(sg_dma_address(sg));
                                todo -= sg_dma_len(sg);
                                sg++;
                        }
HERE ==>       *(rp++)=cpu_to_le32(BT848_RISC_WRITE|BT848_RISC_EOL|
                                            todo);
                        *(rp++)=cpu_to_le32(sg_dma_address(sg));
                        offset += todo;
                }
                offset += padding;
        }
