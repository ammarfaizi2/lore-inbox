Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269229AbRIDVEO>; Tue, 4 Sep 2001 17:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269223AbRIDVEE>; Tue, 4 Sep 2001 17:04:04 -0400
Received: from smtp2.ihug.co.nz ([203.109.252.8]:38412 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S269206AbRIDVDs>;
	Tue, 4 Sep 2001 17:03:48 -0400
Message-ID: <3B9541C1.5BEFE0BA@ihug.co.nz>
Date: Wed, 05 Sep 2001 09:04:01 +1200
From: David Rundle <davekern@ihug.co.nz>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: gcc
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi i need help i have a data struct that matchs some hardwear but 
gcc is alignin it this meins it is out of sync whit the hardwear 
like 
char is              2 bytes 
long double is 12 bytes 
will thats what gcc thinks 

so i need to tell gcc not to align the data struct 

may be like 

noalign struct ........ 

the main prob is whit long double st[8] 

gcc make long double 12 bytes when it need to be 10 bytes 
  

think you 
  

struct _i386_fpu_st 
{ 
  long long  significand; 
  unsigned char       exponent   ; 
  /* unsigned long       test ; */ 

} ; 

struct _i386_fpu 
{ 
  unsigned short control ; 
  unsigned short rev0    ; 
  unsigned short status  ; 
  unsigned short rev1    ; 
  unsigned short tag     ; 
  unsigned short rev2    ; 
  unsigned long  instructionPointer ; 
  unsigned short instructionSelector ; 
  unsigned short opcode  ; 
  unsigned long  operandPointer ; 
  unsigned short operandSelector ; 
  unsigned short rev3  ; 
  long double    st[8] ; 

  /* struct _i386_fpu_st st[8] ; */ 

  unsigned long rev[400] ; 

  
} ; 

extern struct _i386_fpu * i386_fpuInit(void) ;
