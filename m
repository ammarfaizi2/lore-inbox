Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131884AbRAIVZO>; Tue, 9 Jan 2001 16:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRAIVZE>; Tue, 9 Jan 2001 16:25:04 -0500
Received: from obelix.plusnet.ch ([194.158.230.8]:33297 "EHLO
	obelix.spectraweb.ch") by vger.kernel.org with ESMTP
	id <S131884AbRAIVYv>; Tue, 9 Jan 2001 16:24:51 -0500
Message-Id: <200101092118.WAA01032@pingu.hargarten>
Subject: Re: Did anybody have compiled nvidia driver with 2.4.0. (final)  
	kernel ?
From: Marcel Weber <mmweber@ncpro.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="=-Cu/fB4899IxmscDgWMr3"
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 09 Jan 2001 22:19:59 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Cu/fB4899IxmscDgWMr3
Content-Type: text/plain


 
Yes I did
 
It's not that difficult: I've got SuSE 7.0 with xfree86 4.0.2 (SuSE
packages) and Kernel 2.4.0 final. Take the nvidia 0.9-5 tarballs. Unpack
them. Apply this patch (attached patch < patch... from within the
NVIDIA_kernel directory):

Okay, if you try to compile it complains about some unmap stuff. 

Open nv.c

Go to line 860. Remove all the lines from and including the else
expression. Go some lines up and remove the if expression looking for
the right kernel version. Now, you have the declaration for the 2.4.0
kernel, right. 
 
Save and exit

Now do a make.

For beeing sure copy the NVdriver to /lib/modules/2.4.0/video/NVdriver

Try a modprobe NVdriver. With a lsmod it should appear now. Okay no
configure X and glx as before.

Works perfectly on my system

Enjoy

Marcel




________________________________________________________________________

Marcel Weber 
mmweber@ncpro.com 
http://www.ncpro.com 


Made and sent with Linux 



________________________________________________________________________

Marcel Weber 
mmweber@ncpro.com 
http://www.ncpro.com 


Made and sent with Linux 

--=-Cu/fB4899IxmscDgWMr3
Content-Type: text/html; charset=utf-8

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/0.8">
</HEAD>
<BODY><pre><br>
 <br>
Yes I did<br>
 <br>
It's not that difficult: I've got SuSE 7.0 with xfree86 4.0.2 (SuSE<br>
packages) and Kernel 2.4.0 final. Take the nvidia 0.9-5 tarballs. Unpack<br>
them. Apply this patch (attached patch &lt; patch... from within the<br>
NVIDIA_kernel directory):<br>
<br>
Okay, if you try to compile it complains about some unmap stuff. <br>
<br>
Open nv.c<br>
<br>
Go to line 860. Remove all the lines from and including the else<br>
expression. Go some lines up and remove the if expression looking for<br>
the right kernel version. Now, you have the declaration for the 2.4.0<br>
kernel, right. <br>
 <br>
Save and exit<br>
<br>
Now do a make.<br>
<br>
For beeing sure copy the NVdriver to /lib/modules/2.4.0/video/NVdriver<br>
<br>
Try a modprobe NVdriver. With a lsmod it should appear now. Okay no<br>
configure X and glx as before.<br>
<br>
Works perfectly on my system<br>
<br>
Enjoy<br>
<br>
Marcel<br>
<br>
<br>
<br>
<br>
________________________________________________________________________<br>
<br>
Marcel Weber <br>
mmweber@ncpro.com <br>
http://www.ncpro.com <br>
<br>
<br>
Made and sent with Linux </pre><br>

<HR>
<h4>Marcel Weber 
<br>
mmweber@ncpro.com 
<br>
http://www.ncpro.com 
<br>

<br>
</h4>
<h5>Made and sent with Linux </h5>
</BODY>
</HTML>

--=-Cu/fB4899IxmscDgWMr3--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
