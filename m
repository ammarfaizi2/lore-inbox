Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271918AbRIDJXT>; Tue, 4 Sep 2001 05:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271919AbRIDJXK>; Tue, 4 Sep 2001 05:23:10 -0400
Received: from urc1.cc.kuleuven.ac.be ([134.58.10.3]:16257 "EHLO
	urc1.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S271918AbRIDJW5>; Tue, 4 Sep 2001 05:22:57 -0400
Message-ID: <3B9498A6.5B216ABE@pandora.be>
Date: Tue, 04 Sep 2001 11:02:30 +0200
From: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
Organization: MyHome
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl-BE, nl, en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Dos2Linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I translate the following piece of DOS-code to linux?

static union {
  unsigned int *a;      // One 32 bits address
  unsigned long  l;     // One 32 bits long
  unsigned int w[2];    // Two 16 bits words
  unsigned char  b[4];  // Four 8 bits bytes
} DMAaddr;

static union {
  signed int w;         // One 16 bits words
  signed char  b[2];    // Two 8 bits bytes
} DMAcntr;

...

static void setadr( unsigned int far *buff, unsigned int length )
{
  unsigned int lw;

  lw = FP_SEG( buff );                // Segment address of buffer
  DMAaddr.w[1] = ( lw >> 12 ) & 0xf;    // Makes real 32bit address
  DMAaddr.w[0] = ( lw << 4 ) & 0xfff0;
  DMAaddr.l += ( unsigned long )FP_OFF( buff );
  DMAcntr.w = length;
}


Thanks,
mc303

-- 
Ing. Bart Vandewoestyne			 Bart.Vandewoestyne@pandora.be
Hugo Verrieststraat 48			       GSM: +32 (0)478 397 697
B-8550 Zwevegem			 http://users.pandora.be/vandewoestyne
----------------------------------------------------------------------
"Any fool can know, the point is to understand." - Albert Einstein
