Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130046AbRBTLUg>; Tue, 20 Feb 2001 06:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbRBTLU0>; Tue, 20 Feb 2001 06:20:26 -0500
Received: from [203.197.249.146] ([203.197.249.146]:25559 "EHLO
	indica.wipsys.stph.net") by vger.kernel.org with ESMTP
	id <S130046AbRBTLUN>; Tue, 20 Feb 2001 06:20:13 -0500
From: "Srinivas Surabhi" <srinivas.surabhi@wipro.com>
To: linux-kernel@vger.kernel.org
X-Mailer: Netscape Messenger Express 3.5.2 [Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)]
Date: Tue, 20 Feb 2001 16:26:29 +0530
Message-ID: <77452C3A15FD.AAA5AD7@vindhya.mail.wipro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In application program ,code for call to write system call is given
below...
      #include<fcntl.h>
    main()
	 {
	  char* buff="hello"; 
	  int count,fd;
	 fd=open("/dev/pseudo",O_RDWR);
	  write(fd,buff,5);
	  }
	  
In driver module code for getting the buffer and count 

    #include<all related header files...>
     
    int psuedo_write(struct inode*in,struct file*fp,char *buf,int count)
    {
      kprintf("<1>pseudo_write routine called \n");
      kprintf("<1>count=%d \n",count);
      kprintf("<1>buffer=%s \n",buff);
      return 0;
    } 
/******so here after inserting the module into the kernel using insmod 
pseudo.o and executing the application cc -c pseudo_app.c, the o/p on
console is *****/

"pseudo_write routine called" 
"count=9988345352" /*garbage*/
"buffer=@#%h" .   /*garbage*/
 
/*** but neither the  buffer is carried from user space to kernel space nor
the count, why?***/Please help me out.



