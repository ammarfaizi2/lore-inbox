Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129377AbRBTKxs>; Tue, 20 Feb 2001 05:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129253AbRBTKxj>; Tue, 20 Feb 2001 05:53:39 -0500
Received: from [203.197.249.146] ([203.197.249.146]:38102 "EHLO
	indica.wipsys.stph.net") by vger.kernel.org with ESMTP
	id <S129246AbRBTKx3>; Tue, 20 Feb 2001 05:53:29 -0500
From: "Srinivas Surabhi" <srinivas.surabhi@wipro.com>
To: linux-kernel@vger.kernel.org
Subject: parameters passing problem in driver module
X-Mailer: Netscape Messenger Express 3.5.2 [Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)]
Date: Tue, 20 Feb 2001 16:07:55 +0530
Message-ID: <77452C3AEA9.AAA40DE@vindhya.mail.wipro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In application program ,code for call to write system call is given
below...
      #include<fcntl.h>
    main()
	 { 
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
the count, why?***/Please help me
out.


