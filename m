Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbRCUC3r>; Tue, 20 Mar 2001 21:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131063AbRCUC3g>; Tue, 20 Mar 2001 21:29:36 -0500
Received: from rmx195-mta.mail.com ([165.251.48.42]:56826 "EHLO
	rmx195-mta.mail.com") by vger.kernel.org with ESMTP
	id <S130516AbRCUC32>; Tue, 20 Mar 2001 21:29:28 -0500
Message-ID: <382436856.985141648588.JavaMail.root@web584-mc>
Date: Tue, 20 Mar 2001 21:27:28 -0500 (EST)
From: Lee Chin <leechin@mail.com>
To: linux-kernel@vger.kernel.org
Subject: socket close problems
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 63.206.124.79
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On linux I have the following problem:
I accept connections from client sockets, read the request and send data
back and close the socket.

After a while, I run out of file descriptors... and when I run netstat, all
my connections to the clients are in state CLOSING...  and I know the client
has received all the data and disconnected too.

What could I be doing wrong?  The socket is set obtained via the accept
system call.  I set the socket to non blocking via fcntl and use
SO_REUSEADDR via setsockopt... and after using the socket for read and
write, I simply call shutdown followed by a close

Thanks
Lee


______________________________________________
FREE Personalized Email at Mail.com
Sign up at http://www.mail.com/?sr=signup
