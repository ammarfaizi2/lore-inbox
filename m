Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290338AbSAPB1e>; Tue, 15 Jan 2002 20:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290326AbSAPB0L>; Tue, 15 Jan 2002 20:26:11 -0500
Received: from ns.ithnet.com ([217.64.64.10]:1043 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S290328AbSAPBZR>;
	Tue, 15 Jan 2002 20:25:17 -0500
Message-Id: <200201160125.CAA06756@webserver.ithnet.com>
Date: Wed, 16 Jan 2002 02:25:11 +0100
Subject: OOM kill in 2.4.18-pre4
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,                                                          
                                                                      
I just happened to try make -j on a too small box. Obviously I ran    
into OOM. What I find a bit strange about it is the selection of      
processes that got killed.                                            
After reviewing the code in oom_kill.c I must admit I find it kind of 
too smart for real live.                                              
In my situation the first thing killed was mozilla, though being      
somewhere in the background and not reponsible for the OOM situation. 
The next 2 processes killed were my beloved setis. Obviously because  
they were nice :-)                                                    
And the last thing was the xterm I did make -j.                       
My personal taste would be that the guy _producing_ the situation     
should be punished first, not poor mozilla (only because its big).    
I can very well imagine a situation on an (e.g.) oracle server, where 
you start just one thing too much and your primary server goal        
(oracle) gets kicked out because you did  something stupid.           
I know Rik would say: your fault ;-)                                  
But, hey, I probably paid for the server and then kernel tells me:    
make my day, a*hole...                                                
                                                                      
Guess you know what I mean :-)                                        
Is anybody against making it a bit less intelligent, and more real    
live adequate?                                                        
                                                                      
Regards,                                                              
Stephan                                                               
