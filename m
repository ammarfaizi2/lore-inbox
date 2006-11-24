Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757577AbWKXC7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577AbWKXC7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 21:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757583AbWKXC7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 21:59:37 -0500
Received: from nz-out-0102.google.com ([64.233.162.196]:1624 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1757577AbWKXC7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 21:59:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kMXiDaJXk0QnB1xwRmUubRhzRzwFBysv2Dw5+uozDI9Rlo3v+eMbzAnXPysqG1VHEN0LgzNHs+WF5Rqs/m8z4nAxi2PMGhBOgG5am9RcW3Od+Y8x50FZx80YuITGwNnX4Aik5kuMf6kszkz1EZ9e1H4jjyYWPw0i7rrqtPSvTyg=
Message-ID: <f55850a70611231859k57a96dd2l1df11a26f10caf1f@mail.gmail.com>
Date: Fri, 24 Nov 2006 10:59:35 +0800
From: "Zhao Xiaoming" <xiaoming.nj@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: filp_open fail with ENOTDIR in kernel 2.6.16
In-Reply-To: <f55850a70611231846p2109188by84283d0b64fc8853@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f55850a70611231846p2109188by84283d0b64fc8853@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the disterbing. Although the problem wasted me half a day, I
just found the key problem and solved it. It's caused by improper
parameter passing during system calls.
Thanks.

On 11/24/06, Zhao Xiaoming <xiaoming.nj@gmail.com> wrote:
> I'm porting some kernel module codes from kernel 2.4 to 2.6. The codes
> used to work well under 2.4 kernel. In 2.6 environment, the problem is
> filp_open("/root/test.txt",O_RDONLY,0) always return -20 (ENOTDIR).
> But the regular file "/root/test.txt" does exist. What's wrong?
>
