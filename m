Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290677AbSBLBb5>; Mon, 11 Feb 2002 20:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290687AbSBLBbs>; Mon, 11 Feb 2002 20:31:48 -0500
Received: from stephens.ittc.ku.edu ([129.237.125.220]:43477 "EHLO
	stephens.ittc.ku.edu") by vger.kernel.org with ESMTP
	id <S290677AbSBLBbd>; Mon, 11 Feb 2002 20:31:33 -0500
Message-ID: <3C687074.6090902@ittc.ku.edu>
Date: Mon, 11 Feb 2002 19:31:32 -0600
From: Sandhya Rallapalli <sandhya@ittc.ku.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010816
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: skb->data bytes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    As a part of my research work, I've been working on introduction of
bit errors into packets. The main purpose is to choose a random byte
from (skb->head) to (skb->tail) (header & data) and change a bit in the
selected byte. And then, I test the throughput variation according to
the variation in ber using ttcp.

Here, I face a problem:
If a random byte within (skb->head) and (skb->data + 65) is chosen, the 
throughput is acceptable. But, if a byte outside (skb->head) to 
(skb->data + 65) is chosen, the transmission stops. The link becomes 
congested and netstat shows a non-changing number of bytes in Send-Q 
section. i.e., (skb->data + 66) to (skb->tail) are not allowed to be erred.
Is there any significance to the 65th byte and beyond in skb->data?

Thanks,
-Sandhya.



