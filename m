Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKMMQ6>; Mon, 13 Nov 2000 07:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbQKMMQs>; Mon, 13 Nov 2000 07:16:48 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:49682 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129050AbQKMMQh>; Mon, 13 Nov 2000 07:16:37 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Message-ID: <CA256996.004352F8.00@d73mta05.au.ibm.com>
Date: Mon, 13 Nov 2000 17:29:48 +0530
Subject: reliability of linux-vm subsystem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When i run following code many times.
System becomes useless till all of the instance of this programming are
killed by vmm.
Till that time linux doesn't accept any command though it switches from one
VT to another but its useless.
The above programme is run as normal user previleges.
Theoretically load should increase but system should services other users
too.
but this is not behaving in that way.
___________________________________________________________________
main()
{
     char *x[1000];
     int count=1000,i=0;
     for(i=0; i <count; i++)
          x[i] = (char*)malloc(1024*1024*10); /*10MB each time*/

}
_______________________________________________________________________
If i run above programm for 10 times , then system is useless for around
5-7minutes on PIII/128MB.

regards,
Anil


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
