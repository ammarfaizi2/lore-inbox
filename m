Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292818AbSB0RZ4>; Wed, 27 Feb 2002 12:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292826AbSB0RZl>; Wed, 27 Feb 2002 12:25:41 -0500
Received: from brev.stud.ntnu.no ([129.241.56.70]:38099 "EHLO
	brev.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S292840AbSB0RZX>; Wed, 27 Feb 2002 12:25:23 -0500
Date: Wed, 27 Feb 2002 18:25:20 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020227182520.C22422@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020227125611.A20415@stud.ntnu.no> <20020227.040653.58455636.davem@redhat.com> <20020227132454.B24996@stud.ntnu.no> <20020227.042845.54186884.davem@redhat.com> <20020227.042845.54186884.davem@redhat.com>; <20020227170321.B22422@stud.ntnu.no> <3C7D0510.2C300D12@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7D0510.2C300D12@redhat.com>; from arjanv@redhat.com on Wed, Feb 27, 2002 at 04:10:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven:
> google for nttcp
> runs a nice tcp performance test...

Ok, here's some numbers:

UDP:
kiwi:~/nttcp-1.47# ./nttcp -T -v -r -u 129.241.57.161
nttcp-l: nttcp, version 1.47
nttcp-l: Pid=3702
nttcp-l: send window size = 65535
nttcp-l: receive window size = 65535
nttcp-l: buflen=4096, bufcnt=2048, dataport=5038/udp
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: Pid=1820, InetPeer= 129.241.57.160
nttcp-1: Optionline="nttcp@-t@-l4096@-n2048@-u@-v@-f@%9b%8.2rt%8.2ct%12.4rbr%12.4cbr%8c%10.2rcr%10.1ccr@-N1"
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: from ?: "129.241.57.160" (=dataport: 5038)
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: send window size = 65535
nttcp-1: receive window size = 65535
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: buflen=4096, bufcnt=2048, dataport=5038/udp

nttcp-l: got EOF
nttcp-l: received 7725056 bytes
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  7725056    0.07    0.07    878.2714    882.8635    1887  26816.93   26957.1
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: transmitted 8388608 bytes
nttcp-l: try to get outstanding messages from 1 remote clients
1  8388608    0.07    0.05    966.3321   1342.1773    2051  29533.31   41020.0
nttcp-1: exiting

TCP:
kiwi:~/nttcp-1.47# ./nttcp -T -v -r 129.241.57.161   
nttcp-l: nttcp, version 1.47
nttcp-l: Pid=3705
nttcp-l: accept from 129.241.57.161
nttcp-l: send window size = 16384
nttcp-l: receive window size = 87380
nttcp-l: buflen=4096, bufcnt=2048, dataport=5038/tcp
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: Pid=1821, InetPeer= 129.241.57.160
nttcp-1: Optionline="nttcp@-t@-l4096@-n2048@-v@-f@%9b%8.2rt%8.2ct%12.4rbr%12.4cbr%8c%10.2rcr%10.1ccr@-N1"
nttcp-1: from ?: "129.241.57.160" (=dataport: 5038)
nttcp-1: send window size = 16384
nttcp-1: receive window size = 87380
nttcp-1: buflen=4096, bufcnt=2048, dataport=5038/tcp

nttcp-l: received 8388608 bytes
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  8388608    0.08    0.05    865.7309   1342.1773    2177  28084.16   43540.0
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: transmitted 8388608 bytes
1  8388608    0.08    0.04    864.4930   1677.7216    2048  26382.23   51200.0
nttcp-1: exiting


nttcp on the receiving host is running throuhg xinetd, I don't think that
impacts the performance, tho.

-- 
Thomas
