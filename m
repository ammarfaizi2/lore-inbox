Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVAJSja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVAJSja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVAJSfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:35:39 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:28431 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262286AbVAJSdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:33:25 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: John Richard Moser <nigelenki@comcast.net>, Andre Tomt <andre@tomt.net>
Subject: Re: printf() overhead
Date: Mon, 10 Jan 2005 20:33:14 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <41E18522.7060004@comcast.net> <41E188FE.7010609@tomt.net> <41E19F21.20001@comcast.net>
In-Reply-To: <41E19F21.20001@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501102033.14028.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 January 2005 23:16, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Andre Tomt wrote:
> | John Richard Moser wrote:
> |
> |> using strace to run a program takes aeons.  Redirecting the output to a
> |> file can be a hundred times faster sometimes.  This raises question.
> |>
> |> I understand that output to the screen is I/O.  What exactly causes it
> |> to be slow, and is there a possible way to accelerate the process?
> |
> |
> | The terminal is a major factor; gnome-terminal for example can be
> | *extremely* slow.
> |
> 
> Is there a way to give the data to the terminal and let the program go
> while that happens?  Or is there an execution path (i.e. terminal says
> "WTF NO") that can be missed that way?

Buffering is finite. strace output most likely overflow it.

Also while strace may finish already, you won't see it in gnome terminal
until entire strace stdout/stderr is drawn. You will wait anyway. :)
--
vda

