Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318303AbSGRSAo>; Thu, 18 Jul 2002 14:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318304AbSGRSAn>; Thu, 18 Jul 2002 14:00:43 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:59463 "EHLO
	devil.stev.org") by vger.kernel.org with ESMTP id <S318303AbSGRSAn>;
	Thu, 18 Jul 2002 14:00:43 -0400
Message-ID: <001701c22e85$240635b0$0501a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: "Kevin Curtis" <kevin.curtis@farsite.co.uk>,
       <linux-kernel@vger.kernel.org>
References: <7C078C66B7752B438B88E11E5E20E72E0EF451@GENERAL.farsite.co.uk>
Subject: Re: Closing a socket
Date: Thu, 18 Jul 2002 19:01:28 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

either use non-blocking sockets
or send a signal to the other process
to make it exit from the read.

> I have implemented a new socket address family and have noted that
> from a multi-threaded application, if a thread calls close(fd) while a
> second thread has a blocking read outstanding, the sockets release() is
not
> called.  Is this correct?  How can one unblock the read in order to do the
> close.
>



