Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbTDFV7k (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbTDFV7k (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:59:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17552
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263131AbTDFV7h (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 17:59:37 -0400
Subject: Re: [PATCH] new syscall: flink
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: oliver@neukum.name
Cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <200304062156.37325.oliver@neukum.org>
References: <3E907A94.9000305@kegel.com>
	 <200304062156.37325.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049663559.1602.46.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 22:12:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 20:56, Oliver Neukum wrote:
> If you have an fd, the permissions based on the path are already
> bypassed, whether you can call flink or not, aren't they?

It is actually rather more complicated. Suppose I give you a pipe
pair handle. You can flink what was a private object and has no
meaning as a name.

Suppose I give you a socket what does the call man ?

Suppose I give you a handle to an anonymous mapping ?

Suppose I give you a handle to data, how do you know what disk
it belongs to ?

Suppose I give you an O_RDONLY handle to a file which you then
flink and gain write access too ?

