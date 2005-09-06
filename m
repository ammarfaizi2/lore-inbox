Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVIFJPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVIFJPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 05:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVIFJPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 05:15:52 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:61209 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964785AbVIFJPw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 05:15:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AZpvtW0oOhWO+DKqDcMyLINoS0ff9gQOH9L6CkgzlA8chRz5/m/lgQm1/wf9duq7on6lMCKGhPPKIgcpYDSQlJ5rQB4Q+7wSxhEqoC34ZzRhO+poQqXNu+H6wGHP0mPDJdPr4Vq77zlv5RiSbFDU6zs0yqMhyhFs4Rmuf5EUYIg=
Message-ID: <6b5347dc0509060215128d477e@mail.gmail.com>
Date: Tue, 6 Sep 2005 17:15:51 +0800
From: "Sat." <walking.to.remember@gmail.com>
Reply-To: walking.to.remember@gmail.com
To: linux-kernel@vger.kernel.org
Subject: what will connect the fork() with its following code ? a simple example below:
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if(!(pid=fork())){
     ......
     printk("in child process");
     ......
}else{
     .....
     printk("in father process"); 
     .....
}

this is a classical example, when the fork() system call runs, it will
build a new process and active it . while the schedule() select the
new process it will run. this is rather normal.

but there is always a confusion in my minds. 
because , sys_fork() only copies father process and configure some new
values., and do nothing . so the bridge  between the new process and
its following code, printk("in child process"), seems disappear . so I
always believe that the new process should have a pointer which point
the code "printk("in child process");". except this , there are not
any connection between them ?

very confused :( 

any help will  appreciate  !



-- 
Sat.
